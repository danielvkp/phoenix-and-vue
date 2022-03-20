<template>
  <div class="">
    <h2 class="mb-4 blue-grey--text font-weight-light">LISTADO USUARIOS</h2>

    <loader v-if="isloading"></loader>

    <v-row dense align="center">
      <v-col cols="12" md="3">
        <v-text-field small dense outlined v-model="query.email" label="Busqueda" hide-details></v-text-field>
      </v-col>
      <v-col cols="12" md="3">
        <v-btn @click="sendEmail" class="white--text" color="blue">nuevo</v-btn>
      </v-col>
    </v-row>

    <v-row dense class="mt-6 mb-3">
      <v-col cols="12">
        <v-pagination :total-visible="7" :disabled="isloading" @input="next" v-model="pagination.page_number" :length="pagination.total_pages"></v-pagination>
      </v-col>
    </v-row>

    <v-data-table :headers="headers" :items="items" disable-pagination hide-default-footer item-key="id" class="elevation-1 mt-6">
      <template v-slot:item.action="{ item }">
        <v-icon @click="" class="mr-2" color="purple">
          mdi-anchor
        </v-icon>
      </template>
    </v-data-table>

  </div>
</template>

<script>
  import debounce from 'lodash/debounce'

  export default {
    data() {
      return {
        user: {
          email: 'danielvkp@live.com',
          password: 'admin'
        },
        pagination: {
          page_number: 1,
          page_size: 10,
          total_entries: 151,
          total_pages: 16,
        },
        items: [],
        query: {
          email: null,
        },
        headers: [{
            text: 'ID',
            value: 'id',
          },
          {
            text: 'email',
            value: 'email'
          },
          {
            text: '',
            value: 'action'
          },
        ]
      }
    },

    watch: {
      'query': {
        immediate: true,
        deep: true,
        handler(n) {
          this.pagination.page_number = 1
          this.debounceQuery(n)
        }
      }
    },

    methods: {
      next(page) {
        this.getPdfs(this.query)
      },

      debounceQuery: debounce(function(n) {
        this.getPdfs(n)
      }, 800),

      getPdfs(query) {
        axios.post(`api/v1/get-users?page=${this.pagination.page_number}`, query).then(res => {
          this.items = res.data.entries
          this.pagination = _.omit(res.data, 'entries')
        }, res => {
          //this.$toast.error('Error consultando listado')
        })
      },

      signin() {
        axios.post(`api/signin`, this.user).then(res => {
          console.log(res.data);
        }, res => {
          console.log('errrrroooorrr');
          //this.$toast.error('Error consultando listado')
        })
      },

      sendEmail() {
        axios.post(`api/v1/send-email`).then(res => {
          console.log(res.data);
        }, res => {
          //this.$toast.error('Error consultando listado')
        })
      }

    },

    computed: {
      isloading() {
        return this.$store.getters.getloading
      }
    }
  }
</script>