<template>
  <div class="">
    <h2 class="mb-4 blue-grey--text font-weight-light">LISTADO INFORMES</h2>

    <loader v-if="isloading"></loader>

    <v-row dense>
      <v-col cols="12" md="3">
        <v-text-field outlined v-model="query.search" label="Busqueda" hide-details></v-text-field>
      </v-col>
    </v-row>

    <v-row dense class="mt-6 mb-3">
      <v-col cols="12">
        <v-pagination :total-visible="7" :disabled="isloading" @input="next" v-model="pagination.current_page" :length="pagination.last_page"></v-pagination>
      </v-col>
    </v-row>

    <v-data-table :headers="headers" :items="items" disable-pagination hide-default-footer item-key="id" class="elevation-1 mt-6">
      <template v-slot:item.url="{ item }">
        <a target="_blank" :href="`documentos/${item.url}`">
          <v-icon class="mr-2" color="orange">
            mdi-cloud-download
          </v-icon>
        </a>

      </template>
      <template v-slot:item.action="{ item }">
        <v-icon @click="eliminarPDF(item)" class="mr-2" color="red">
          mdi-trash-can
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
        pagination: {
          total: 0,
          count: 0,
          per_page: 0,
          current_page: 0,
          total_pages: 0
        },
        base_path: 'api/search-pdfs?page=1',
        items: [],
        query: {
          search: null
        },
        headers: [{
            text: 'ID',
            value: 'id',
          },
          {
            text: 'Nombre',
            value: 'nombre'
          },
          {
            text: 'Archivo',
            value: 'url'
          },
          {
            text: 'Acciones',
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
          this.base_path = 'api/search-pdfs?page=1'
          this.debounceQuery(n)
        }
      }
    },

    methods: {
      next(page) {
        this.base_path = `api/v1/search-pdfs?page=${page}`
        this.getPdfs(this.base_path, this.query)
      },

      debounceQuery: debounce(function(n) {
        this.getPdfs(this.base_path, n)
      }, 800),

      getPdfs(base_path, query) {
        axios.get(`api/v1/search-pdfs`, query).then(res => {
          this.items = res.data.data
          this.pagination = _.omit(res.data, 'data')
        }, res => {
          this.$toast.error('Error consultando listado')
        })
      },

      eliminarPDF(item) {
        axios.get(`api/eliminar-pdf/${item.id}`).then(res => {
          this.items.splice(this.items.indexOf(item), 1)
          this.$toast.sucs('Informe eliminado con exito')
        }, res => {
          this.$toast.error('Error consultando listado')
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