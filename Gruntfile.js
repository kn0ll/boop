module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-livereload');
  grunt.loadNpmTasks('grunt-contrib-requirejs');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-open');
  grunt.loadNpmTasks('grunt-regarde');

  grunt.initConfig({

    // empty dirs for builds
    clean: {
      staging: ['staging/']
    },

    // compiles all .coffee files in coffee/* and moves them into js/*
    coffee: {
      compile: {
        files: grunt.file.expandMapping(['src/coffee/**/*.coffee'], 'staging/js/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.coffee$/, '.js').replace(/src\/coffee\//, '');
          }
        }),
        options: {
          bare: true
        }
      }
    },

    // copies all .js files in coffee/* and moves them into js/*
    // this allows us to put js sources directly inside the coffee
    // directory and use them as normal dependencies
    copy: {
      html: {
        files: grunt.file.expandMapping(['src/**/*.html'], 'staging/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.html$/, '.html').replace(/src\//, '');
          }
        })
      },
      js: {
        files: grunt.file.expandMapping(['src/coffee/**/*.js'], 'staging/js/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.js$/, '.js').replace(/src\/coffee\//, '');
          }
        })
      },
      hbs: {
        files: grunt.file.expandMapping(['src/hbs/**/*.hbs'], 'staging/hbs/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.hbs$/, '.hbs').replace(/src\/hbs\//, '');
          }
        })
      },
      img: {
        files: grunt.file.expandMapping(['src/img/**/*.png'], 'staging/img/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.png$/, '.png').replace(/src\/img\//, '');
          }
        })
      }
    },

    // compiles all .sass files in sass/* and moves them into css/*
    sass: {
      compile: {
        files: grunt.file.expandMapping(['src/sass/**/*.sass'], 'staging/css/', {
          rename: function(destBase, destPath) {
            return destBase + destPath.replace(/\.sass$/, '.css').replace(/src\/sass\//, '');
          }
        })
      }
    },

    // watch for changes to any source files
    // and recompile them or copy them accordingly
    regarde: {
      coffee: {
        files: 'src/coffee/**/*.coffee',
        tasks: ['coffee']
      },
      js: {
        files: 'src/coffee/**/*.js',
        tasks: ['copy:js']
      },
      hbs: {
        files: 'src/hbs/**/*.hbs',
        tasks: ['copy:hbs']
      },
      html: {
        files: 'src/**/*.html',
        tasks: ['copy:html']
      },
      sass: {
        files: 'src/sass/**/*.sass',
        tasks: ['sass']
      },
      livereload: {
        files: [
          'staging/**/*'
        ],
        tasks: ['livereload']
      }
    },

    // create a requirejs module from the compiled js
    requirejs: {
      compile: {
        options: {
          baseUrl: 'staging/js',
          mainConfigFile: 'staging/js/config.js',
          out: 'dist/js/config.js',
          preserveLicenseComments: false,
          //optimize: 'none'
        }
      }
    },

    open: {
      server: {
        url: 'http://localhost:8000'
      }
    }

  });
  
  // compile all source files in src/coffee/
  grunt.registerTask('compile-coffee', [
    'coffee',
    'copy:js'
  ]);

  // compile/copy all sources into staging/
  grunt.registerTask('build-staging', [
    'clean:staging',
    'compile-coffee',
    'sass',
    'copy:hbs',
    'copy:html',
    'copy:img'
  ]);

  grunt.registerTask('default', [
    'build-staging',
    'livereload-start',
    'open',
    'regarde'
  ]);

  // compile all source files in sass/
  // grunt.registerTask('compile-sass', ['sass']);

  // compile all source files
  // grunt.registerTask('compile', ['compile-coffee', 'compile-sass']);

  // compile all source files and create a requirejs built module
  // grunt.registerTask('build', ['compile', 'requirejs']);

};