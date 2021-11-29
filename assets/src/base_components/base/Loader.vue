<template>
    <v-row class="mb-3" justify="center" align="center">
        <v-progress-circular :size="40" :width="3" color="blue" indeterminate></v-progress-circular>
    </v-row>
</template>

<script>
    export default {
        name: 'loader'
    }
</script>