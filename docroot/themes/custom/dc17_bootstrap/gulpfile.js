var promise = require('es6-promise').Promise;  // To run Node.js code asynchronously, this is dependency.
var gulp = require('gulp'),
  watch = require('gulp-watch'),
  prefixer = require('gulp-autoprefixer'),
  sass = require('gulp-sass'),
  csslint = require('gulp-csslint'),
  sourcemaps = require('gulp-sourcemaps'),
  jscs = require('gulp-jscs'), // JS Codestyle
  uglify = require('gulp-uglify'), // JS Minifier
  rigger = require('gulp-rigger'),
  // concat = require('gulp-concat'),
  browserSync = require('browser-sync').create(),
  cssnano = require('gulp-cssnano'),
  rename = require('gulp-rename');


const path = {
  build: {
    styles: 'css/',
    js: 'script/'
  },
  src: {
    styles: 'sass/style.scss',
    js: 'assets/js/script.js'
  },
  watch: {
    styles: 'sass/**/*.scss',
    js: 'assets/js/*.js'
  }
};

gulp.task('styles', function () {
  gulp.src(path.src.styles)
    // .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(prefixer({ browsers: ['last 5 versions'], cascade: false}))
    .pipe(cssnano())
    .pipe(rename({
      suffix: '.min'
    }))
    // .pipe(sourcemaps.write())
    .pipe(gulp.dest(path.build.styles))
    .pipe(browserSync.stream());
});

gulp.task('js', function () {
  return gulp.src(path.src.js)
    .pipe(rigger())
    .pipe(uglify())
    .pipe(rename({
      suffix: '.min'
    }))
    .pipe(gulp.dest(path.build.js))
});

gulp.task('watch', function () {
  watch([path.watch.styles], function() {
    gulp.start('styles');
  });

  watch([path.watch.js], function() {
    gulp.start('js');
  });
});

gulp.task('serve', ['styles'], function () {
  browserSync.init({
    proxy: 'localhost:8000', // VM url or VM IP url.
    ghostMode: { // Browser sync options - monitor user behaviours.
      clicks: true,
      forms: true
    },
    port: 8000, // Port of our VM.
    reloadOnRestart: true,
    open: false
  });

  watch([path.watch.styles]).on('change', function() {
    gulp.start('styles');
  }, browserSync.reload); //Task to reload when files changed.

  // watch([path.watch.js]).on('change', browserSync.reload);
});

gulp.task('build', [
  'styles',
  'js'
]);

gulp.task('default', ['build', 'watch']);
