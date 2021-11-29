y<template>
    <v-list dense nav>

        <v-list-item :to="{path: '/'}">
            <v-list-item-icon>
                <v-icon color="grey lighten-3">mdi-home</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
                <v-list-item-title class="grey--text text--lighten-3">Inicio</v-list-item-title>
            </v-list-item-content>
        </v-list-item>

        <template v-if="$route.path !== '/'">

            <v-list-item v-for="item in items" :key="item.path" :to="{path: item.path}">
                <v-list-item-icon>
                    <v-icon color="grey lighten-3">{{item.icon}}</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                    <v-list-item-title class="grey--text text--lighten-3" v-html="item.text"></v-list-item-title>
                </v-list-item-content>
            </v-list-item>

        </template>

    </v-list>
</template>

<script>
    import {
        menu_items_mixin
    } from '../../global_mixins/menu_items_mixin'

    export default {
        mixins: [menu_items_mixin]
    }
</script>