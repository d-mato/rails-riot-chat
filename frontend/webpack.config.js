var webpack = require('webpack');

module.exports = {
  entry: __dirname + '/src/index',
  output: {
    path: __dirname + '/../public',
    filename: 'bundle.js'
  },

  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    })
  ],
  module: {
    preLoaders: [
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs' }
    ],
    loaders: [
      { test: /\.js$|\.tag$/, exclude: /node_modules/, loader: 'babel', query: { presets: ['es2015'] } },
      { test: /\.css$/, loader: 'style!css' },
      { test: /\.(eot|woff2?|ttf|svg)$/, loader: 'file' },
    ]
  },

  devServer: {
    contentBase: __dirname + '/../public'
  }
};

