var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, '../deploy/www/js/react/');
var APP_DIR = path.resolve(__dirname, 'src');

var config = {
  entry: {
    app: APP_DIR + '/main.js'
  },
  output: {
    path: BUILD_DIR,
    filename: 'rebuildeq.bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?/,
        include: APP_DIR,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react', 'stage-2']
        }
      },
      {
        test: /\.css/,
        loaders: ['style-loader', 'css-loader']
      }
    ]
  }
};

module.exports = config;
