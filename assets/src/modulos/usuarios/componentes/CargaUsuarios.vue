<template>
    <div class="">
        <v-custom-title text="Carga de Usuarios"></v-custom-title>

        <loader v-if="isloading"></loader>

        <v-data-table :headers="headers" :items="usuarios" disable-pagination hide-default-footer item-key="id" class="elevation-1 mt-6">

            <template v-slot:item.sn="{ index }">
                {{ index + 1 }}
            </template>

            <template v-slot:item.nombre="{ item }">
                <v-text-field v-model="item.nombre" placeholder="Nombres" outlined dense hide-details></v-text-field>
                <br>
                <v-text-field v-model="item.apellido" placeholder="Apellidos" outlined dense hide-details></v-text-field>
            </template>

            <template v-slot:item.dni="{ item }">
                <v-text-field v-model="item.celular" placeholder="Celular" outlined dense hide-details></v-text-field>
                <br>
                <v-text-field v-model="item.dni" placeholder="Dni" outlined dense hide-details></v-text-field>
            </template>

            <template v-slot:item.email="{ item }">
                <v-text-field v-model="item.email" placeholder="Email" type="email" outlined dense hide-details></v-text-field>
                <br>
                <v-text-field readonly disabled :value="item.password" :rules="password_rules" type="password" outlined dense hide-details></v-text-field>
            </template>

            <template v-slot:item.apartamento="{ item }">
                <v-text-field v-model="item.apartamento" placeholder="Identificador" outlined dense hide-details></v-text-field>
                <br>
                <v-text-field v-model="item.tamano" placeholder="Tamaño" type="number" step="0.1" outlined dense hide-details></v-text-field>
            </template>

            <template v-slot:item.edificio="{ item }">
                <v-autocomplete v-model="item.edificio" :items="edificios" outlined dense hide-details item-text="nombre" item-value="id"></v-autocomplete>
                <br>
                <v-checkbox v-model="item.cochera" class="mt-1 pb-2 ml-1" hide-details label="Cochera"></v-checkbox>
            </template>

            <template v-slot:item.action="{ item }">
                <v-icon @click="removeUsuario(item)" small class="mr-2" color="red">
                    mdi-trash-can
                </v-icon>
            </template>
        </v-data-table>

        <v-btn @click="addUsuario" class="mt-6 mr-2 white--text" color="orange">nuevo</v-btn>
        <v-btn @click="cargarUsuarios" class="mt-6 white--text" color="blue">guardar</v-btn>
    </div>
</template>

<script>
    import {
        usuario_rules
    } from '../mixins/usuario_rules'

    export default {
        mixins: [usuario_rules],
        data() {
            return {
                edificios: [],
                usuarios: [{
                    nombre: null,
                    apellido: null,
                    celular: null,
                    dni: null,
                    email: null,
                    password: Math.random().toString(36).slice(-8),
                    apartamento: null,
                    tamano: null,
                    cochera: false,
                    edificio: null,
                }],
                headers: [{
                        text: '',
                        value: 'sn',
                    }, {
                        text: 'Datos Usuario',
                        value: 'nombre',
                    },
                    {
                        text: '',
                        value: 'dni'
                    },
                    {
                        text: '',
                        value: 'email'
                    },
                    {
                        text: 'Datos Apartamento',
                        value: 'apartamento'
                    },
                    {
                        text: 'Edificio',
                        value: 'edificio'
                    },
                    {
                        text: '',
                        value: 'action',
                        sortable: false,
                        width: 8
                    },
                ],
            }
        },
        created() {
            this.getEdificios()
        },
        methods: {
            cargarUsuarios() {
                axios.post(`api/cargar-usuarios`, this.usuarios).then(res => {
                    this.handleFails(res.data.fails)
                }, err => {
                    this.$toast.error('Error guardando usuarios')
                })
            },
            handleFails(fails) {
                let filter_fails = fails.filter(x => x != null)
                this.usuarios = this.usuarios.filter(element => {
                    return filter_fails.includes(element.email)
                })
                if (this.usuarios.length > 0) {
                    return this.$toast.warn('Se encontraron errores en los siguientes usuarios');
                }
                return this.$toast.sucs('Carga de usuarios realizada con exito');
            },
            getEdificios() {
                axios.get(`api/get-edificios`).then(res => {
                    this.edificios = res.data
                }, err => {
                    this.$toast.error('Error consultando edificios')
                })
            },
            addUsuario() {
                this.usuarios.push({
                    nombre: null,
                    apellido: null,
                    celular: null,
                    dni: null,
                    email: null,
                    password: Math.random().toString(36).slice(-8),
                    apartamento: null,
                    tamano: null,
                    cochera: false,
                    edificio: null,
                })
            },
            removeUsuario(item) {
                let index_of = this.usuarios.indexOf(item)
                this.usuarios.splice(index_of, 1)
            },
            clearForm() {
                this.usuarios = [{
                    nombre: null,
                    apellido: null,
                    celular: null,
                    dni: null,
                    email: null,
                    password: Math.random().toString(36).slice(-8),
                    apartamento: null,
                    tamano: null,
                    cochera: false,
                    edificio: null,
                }]
            }
        },
        computed: {
            isloading() {
                return this.$store.getters.getloading
            }
        }
    }
</script>

<style>
    .v-data-table>.v-data-table__wrapper>table>tbody>tr>td,
    .v-data-table>.v-data-table__wrapper>table>tbody>tr>th,
    .v-data-table>.v-data-table__wrapper>table>thead>tr>td,
    .v-data-table>.v-data-table__wrapper>table>thead>tr>th,
    .v-data-table>.v-data-table__wrapper>table>tfoot>tr>td,
    .v-data-table>.v-data-table__wrapper>table>tfoot>tr>th {
        padding: 5px 5px !important;
    }

    .theme--light.v-data-table tbody tr:nth-of-type(even) {
        background-color: rgba(0, 0, 0, .10);
    }

    .theme--dark.v-data-table tbody tr:nth-of-type(even) {
        background-color: rgba(0, 0, 0, .5);
    }
</style>