<template>
    <div class="">

        <v-custom-title text="Lista Usuarios"></v-custom-title>

        <v-btn rounded depressed color="blue" class="white--text mr-2" :to="{ path: `/guardar-usuario` }">Nuevo Usuario</v-btn>

        <v-btn rounded depressed color="orange" class="white--text mr-2" :to="{ path: `/guardar-multiples` }">Carga Masiva</v-btn>

        <loader v-if="isloading"></loader>

        <v-row dense class="mt-6 mb-3">
            <v-col cols="12" md="3">
                <v-text-field outlined v-model="query.usuario" label="Usuario" hide-details></v-text-field>
            </v-col>
            <v-col cols="12" md="3">
                <v-text-field outlined v-model="query.edificio" label="Apto / Edificio" hide-details></v-text-field>
            </v-col>
        </v-row>

        <v-custom-pagination :isloading="isloading" v-on:page="next" :pagination="pagination"></v-custom-pagination>

        <v-data-table :headers="headers" :items="usuarios" disable-pagination hide-default-footer item-key="`id_${identificador}`" class="elevation-1 mt-6">
            <template v-slot:item.action="{ item }">
                <router-link :to="{ path: `/guardar-usuario?id=${item.id}` }" class="action-buttons">
                    <v-icon small class="mr-2" color="blue">
                        mdi-pencil
                    </v-icon>
                </router-link>
                <v-icon @click="confirmDialog(item)" small class="mr-2" color="red">
                    mdi-trash-can
                </v-icon>
            </template>
        </v-data-table>
        <v-confirm-dialog></v-confirm-dialog>
    </div>
</template>

<script>
    import {
        pagination_mixin
    } from '../../../global_mixins/pagination_mixin'

    import debounce from 'lodash/debounce'

    export default {
        mixins: [pagination_mixin],

        data() {
            return {
                query: {
                    usuario: '',
                    edificio: ''
                },
                usuarios: [],
                usuario: {},
                headers: [{
                        text: 'Nombres',
                        value: 'nombre',
                    },
                    {
                        text: 'Apellidos',
                        value: 'apellido'
                    },
                    {
                        text: 'Email',
                        value: 'email'
                    },
                    {
                        text: 'Apartamento',
                        value: 'identificador'
                    },
                    {
                        text: 'Edificio',
                        value: 'edificio'
                    },
                    {
                        text: 'Acciones',
                        value: 'action',
                        sortable: false
                    },
                ],
            }
        },
        watch: {
            'query': {
                immediate: true,
                deep: true,
                handler(n) {
                    this.base_path = 'api/search-usuarios?page=1'
                    this.debounceQuery(n)
                }
            }
        },
        methods: {
            next(page) {
                this.base_path = `api/search-usuarios?page=${page}`
                this.getUsuarios(this.base_path, this.query)
            },

            debounceQuery: debounce(function(n) {
                this.getUsuarios(this.base_path, n)
            }, 800),

            getUsuarios(base_path, query) {
                axios.post(base_path, query).then(res => {
                    this.usuarios = res.data.data
                    this.pagination = res.data.pagination
                }, err => {
                    this.$toast.error('Error consultando usuarios')
                })
            },

            confirmDialog(item) {
                this.usuario = item
                this.$emit('open')
            },
        },
        computed: {
            isloading: function() {
                return this.$store.getters.getloading
            },
        }
    }
</script>