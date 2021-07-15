<template>
  <div>
    <header>
      <div class="header-container">
        <div class="logo-area">
          <img src="logo.webp" alt="Logo" />
          <span> PMS</span>
        </div>
        <div>
          <vs-button to="/setup"> Get Started </vs-button>
        </div>
      </div>
    </header>
    <main>
      <div class="hero">
        <div class="hero-container">
          <div class="hero-text">
            <h4>Modern HR solutions from hunetsystems</h4>
            <h1>Better manage your employees</h1>
            <div class="call-to-action">
              <vs-button to="/setup"> Get Started </vs-button>
            </div>
          </div>
          <div class="hero-animation">
            <lottie-animation
              path="lottie/hero.json"
              :width="400"
              :height="400"
            />
          </div>
        </div>
      </div>
    </main>
    <footer>
      <div>
        <img src="logo.webp" alt="Logo" />
      </div>
      <div></div>
      <div></div>
      <div></div>
    </footer>
  </div>
</template>

<script>
import LottieAnimation from "lottie-vuejs/src/LottieAnimation.vue"; // import lottie-vuejs

export default {
  components: {
    LottieAnimation,
  },
  data: () => ({}),
};
</script>

<style>
header {
  height: 10vh;
  display: flex;
  justify-content: center;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.logo-area {
  display: flex;
  align-items: center;
}

.logo-area img {
  height: 50px;
}

.logo-area span {
  font-size: 28px;
  font-weight: 600;
  padding: 0 20px;
  margin: 0 20px;
  color: #666;
  border-left: solid 2px #666;
}

.header-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 20px;
  max-width: 1200px;
}

.hero {
  height: 60vh;
  display: flex;
  justify-content: center;
  background: linear-gradient(180deg, #fff, rgb(185, 224, 255));
}

.hero-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 1200px;
}

.hero-text {
  padding: 0 30px;
  height: 200px;
}

.hero-text .call-to-action {
  margin-top: 30px;
}

.hero-text .call-to-action .vs-button {
  font-size: 24px;
}

@media only screen and (max-width: 800px) {
  .hero-animation {
    display: none;
  }
}
</style>
