<channels>
  <ul class="list-unstyled">
    <li each={opts.items} class={active: isActive} ><a href="/#/channels/{slug}">{name}</a></li>
  </ul>

  <style scoped>
    ul {
      margin-left: 10px;
    }
  </style>
</channels>
