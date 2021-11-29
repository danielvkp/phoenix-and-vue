<template>
    <div class="">
        <v-app-bar app flat class="nav-t">

            <v-toolbar-title class="text-uppercase grey--text text--darken-1">Administración</v-toolbar-title>

            <v-spacer></v-spacer>

            <v-btn @click="setTheme" icon>
                <v-icon>mdi-invert-colors</v-icon>
            </v-btn>

            <v-app-bar-nav-icon @click.stop="toggleDrawer"></v-app-bar-nav-icon>
        </v-app-bar>
    </div>
</template>

<script>
    export default {
        mounted() {
            let dark = localStorage.getItem('dark') == 'true' ? true : false
            this.$vuetify.theme.dark = dark
        },
        methods: {
            toggleDrawer() {
                this.$emit('toggleDrawer')
            },
            setTheme() {
                this.$vuetify.theme.dark = !this.$vuetify.theme.dark
                localStorage.setItem('dark', this.$vuetify.theme.dark)
            }
        }
    }
</script>