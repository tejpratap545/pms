<template>
  <div class="page">
    <h1>Home</h1>
    <div class="center">
      <vs-card-group>
        <vs-card v-for="card in 6" :key="card" type="4">
          <template #title>
            <h3>Pot with a plant</h3>
          </template>
          <template #img>
            <img src="https://picsum.photos/300/300" alt="" />
          </template>
          <template #text>
            <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit.</p>
          </template>
          <template #interactions>
            <vs-button danger icon>
              <i class="bx bx-heart"></i>
            </vs-button>
            <vs-button class="btn-chat" shadow primary>
              <i class="bx bx-chat"></i>
              <span class="span"> 54 </span>
            </vs-button>
          </template>
        </vs-card>
      </vs-card-group>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",

  middleware: ["auth"],
};
</script>

<style></style>
