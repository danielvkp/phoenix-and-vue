<template>
    <div class="">

        <loader v-if="isloading"></loader>

        <v-card class="mx-auto">

            <v-toolbar color="blue" small dark>
                <v-toolbar-title>Guardar / Editar Usuario</v-toolbar-title>
            </v-toolbar>

            <v-container fluid class="pt-5">

                <v-form ref="form" v-model="valid" lazy-validation>
                    <v-row dense>
                        <v-col cols="12" md="3">
                            <v-text-field v-model="usuario.nombre" outlined label="Nombres (*)" :rules="nombre_rules" required></v-text-field>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-text-field v-model="usuario.apellido" outlined label="Apellidos (*)" :rules="nombre_rules"></v-text-field>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-text-field v-model="usuario.dni" outlined label="Dni" hint="Opcional" persistent-hint :rules="dni_rules" type="number" count="8" step="1"></v-text-field>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-text-field v-model="usuario.celular" outlined label="Celular" hint="Opcional" persistent-hint :rules="celular_rules" type="number" count="9" step="1"></v-text-field>
                        </v-col>
                    </v-row>

                    <v-row dense align="center">
                        <v-col cols="12" md="3">
                            <v-text-field v-model="usuario.user.email" outlined label="Email (*)" :rules="email_rules" required></v-text-field>
                        </v-col>
                        <v-col v-if="usuario.user.id" cols="6" md="2" sm="6">
                            <v-text-field v-model="usuario.user.password" type="password" outlined label="Contraseña (*)" :rules="password_rules"></v-text-field>
                        </v-col>
                        <v-col v-else cols="6" md="2" sm="6">
                            <v-text-field v-model="usuario.user.password" type="password" outlined label="Contraseña (*)" :rules="dumb_password_rules"></v-text-field>
                        </v-col>
                        <v-col cols="6" md="2" sm="6">
                            <v-btn @click="generarPassword" class="mb-4 white--text" color="blue">Generar</v-btn>
                        </v-col>
                    </v-row>

                    <h3 class="mb-3 blue-grey--text text--darken-1 font-weight-light">Prueba datos apartamento</h3>

                    <div v-for="(apartamento, index) in usuario.apartamento" :key="index">

                        <v-alert v-if="has_errors(index)" small dissmisible dense outlined color="red">
                            Error validando apartamento
                        </v-alert>

                        <v-row dense>
                            <v-col cols="12" md="2">
                                <v-text-field v-model="apartamento.identificador" outlined label="Identificador (*)" :rules="ident_rules" required></v-text-field>
                            </v-col>
                            <v-col cols="12" md="2">
                                <v-text-field v-model="apartamento.tamano" outlined label="Tamaño (mts)" :rules="size_rules" type="number" step="0.1"></v-text-field>
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-text-field v-model="apartamento.descripcion" outlined label="Descripción"></v-text-field>
                            </v-col>
                            <v-col cols="12" md="2">
                                <v-checkbox v-model="apartamento.cochera" label="Cochera"></v-checkbox>
                            </v-col>
                        </v-row>

                        <v-row dense align="center">
                            <v-col cols="12" md="3">
                                <v-autocomplete v-model="apartamento.edificio_id" :items="edificios" outlined label="Edificio" item-text="nombre" item-value="id"></v-autocomplete>
                            </v-col>
                            <v-col cols="12" md="3">
                                <v-btn v-if="index>0" outlined @click="deleteApartamento(apartamento)" text color="red" class="mb-4">Eliminar</v-btn>
                            </v-col>
                        </v-row>

                    </div>

                    <v-row dense>
                        <v-col cols="12">
                            <v-btn @click="saveUsuario" rounded depressed :disabled="isloading || !valid" class="white--text" color="success">guardar</v-btn>
                            <v-btn @click="addApartamento" rounded depressed :disabled="isloading || !valid" class="white--text" color="orange">nuevo</v-btn>
                        </v-col>
                    </v-row>
                </v-form>
            </v-container>
        </v-card>
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
                messages: [],
                edificios: [],
                alert: false,
                usuario: {
                    id: null,
                    nombre: null,
                    apellido: null,
                    celular: null,
                    dni: null,
                    user: {
                        id: null,
                        email: null,
                        password: 'dummy-password'
                    },
                    apartamento: [{
                        id: null,
                        identificador: null,
                        tamano: 0,
                        cochera: false,
                        descripcion: null,
                        edificio_id: null,
                    }]
                }
            }
        },

        created() {
            this.getEdificios();
            (this.$route.query.id) ? this.getUsuario(this.$route.query.id): null
        },

        methods: {
            saveUsuario() {
                if (!this.$refs.form.validate()) {
                    return this.$toast.warn('Error de validando formulario')
                }
                axios.post('api/save-usuario', this.usuario).then(res => {
                    this.$toast.sucs('Registro actualizado')
                    this.$router.push('/lista-usuarios')
                }, res => {
                    if (res.response.status == 301) {
                        return this.$toast.warn(res.response.data)
                    }
                    if (res.response.status == 302) {
                        return this.messages = res.response.data.messages
                    }
                    this.$toast.error('Error guardando usuario')
                })
            },
            getUsuario(id) {
                axios.get(`api/get-usuario/${id}`).then(res => {
                    this.usuario = res.data
                    this.$set(this.usuario.user, 'password', 'dummy-password')
                    this.$refs.form.resetValidation()
                }, res => {
                    this.$toast.error('Error consultando usuario')
                })
            },
            getEdificios() {
                axios.get(`api/get-edificios`).then(res => {
                    this.edificios = res.data
                }, err => {
                    this.$toast.error('Error consultando edificios')
                })
            },
            generarPassword() {
                let password = Math.random().toString(36).slice(-8);
                this.usuario.user.password = password
            },
            has_id() {
                return this.usuario.id != null
            },
            has_errors(index) {
                return this.messages.includes(index)
            },
            addApartamento() {
                this.usuario.apartamento.push({
                    id: null,
                    identificador: null,
                    tamano: null,
                    cochera: false,
                    descripcion: null,
                    edificio_id: null,
                })
            },
            deleteApartamento(apartamento) {
                this.usuario.apartamento.splice(this.usuario.apartamento.indexOf(apartamento), 1)
            }
        },
        computed: {
            isloading: function() {
                return this.$store.getters.getloading
            }
        }
    }
</script>