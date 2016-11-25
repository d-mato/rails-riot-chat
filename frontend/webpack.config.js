var webpack = require('webpack');

module.exports = {
  entry: './src/index',
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
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader' }
    ],
    loaders: [
      { test: /\.js$|\.tag$/, exclude: /node_modules/, loader: 'babel-loader' },
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      { test: /\.(eot|woff2?|ttf|svg)$/, loader: 'file-loader' },
    ]
  },

  devServer: {
    contentBase: __dirname + '/../public'
  }
};

