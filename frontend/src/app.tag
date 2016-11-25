require('./sidebar.tag')
require('./main.tag')

<app>
  <div class="container">
    <div class="row">
      <sidebar class="col-xs-2"></sidebar>
      <main class="col-xs-10"></main>
    </div>
  </div>

  <style scoped>
    .container {
      width: 1200px;
      margin: 0;
    }
    sidebar {
      background-color: #08022d;
      height: 100vh;
    }
    main {
      background-color: #e9e9ef;
      height: 100vh;
    }
  </style>
</app>
