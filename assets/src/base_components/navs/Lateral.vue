<template>
  <v-navigation-drawer color="#2196F3" @input="getthe" v-model="local_drawer" :mini-variant="mini" app dark>

    <div class="background-nav"></div>

    <v-list-item @click.stop="mini = !mini" class="">

      <v-list-item-content>
        <v-list-item-title>
          Phoenix - Vue
        </v-list-item-title>
      </v-list-item-content>

    </v-list-item>

    <v-divider></v-divider>

    <default-lateral></default-lateral>

  </v-navigation-drawer>

</template>

<script>
  import defaultLateral from './defaultLateral.vue'
  export default {
    props: ['drawer'],
    components: {
      defaultLateral
    },
    methods: {
      getthe(e) {
        this.$emit('emitInnputDrawer', e)
      }
    },
    data() {
      return {
        lateral: 'defaultLateral',
        mini: false,
        local_drawer: true,
      }
    },
    watch: {
      drawer: {
        immediate: true,
        handler: function(n) {
          this.local_drawer = n
        }
      },
    }
  }
</script>

<style media="screen">
  .v-navigation-drawer .v-list .v-list-item>.v-list__tile .v-list__tile__title {
    font-size: 14px !important;
    font-weight: 100;
    padding: 0;
  }

  .v-list--dense .v-list-item .v-list-item__subtitle,
  .v-list--dense .v-list-item .v-list-item__title,
  .v-list-item--dense .v-list-item__subtitle,
  .v-list-item--dense .v-list-item__title {
    font-size: 17px !important;
    font-weight: 300;
    text-transform: capitalize;
  }


  .v-application--is-ltr .v-list-item__action:first-child,
  .v-application--is-ltr .v-list-item__icon:first-child {
    margin-right: 15px !important;
  }

  .v-list--dense .v-list-item .v-list-item__icon,
  .v-list-item--dense .v-list-item__icon {
    opacity: .9;
    color: #fff;
  }

  .v-list--nav .v-list-item {
    padding: 8px 15px !important;
  }

  .v-list-item--active:before,
  .v-list-item--active:hover:before,
  .v-list-item:focus:before {
    /*opacity: 1*/
  }

  .theme--dark.v-list-item--active:before,
  .theme--dark.v-list-item--active:hover:before,
  .theme--dark.v-list-item:focus:before {
    /*opacity: 0;*/
  }

  .avatar-b-color {
    background-color: #fff !important;
  }

  /*.v-list-item--active {
        background-color: #383c42 !important;
    }*/

  .theme--dark.v-list-item--active:hover::before,
  .theme--dark.v-list-item--active::before {
    /*opacity: 0 !important;*/
  }
</style>