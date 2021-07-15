<template>
	<div class="loader-container">
		<lottie-animation path="lottie/loading.json" :width="256" :height="256" />
	</div>
</template>

<script>
import LottieAnimation from 'lottie-vuejs/src/LottieAnimation.vue'; // import lottie-vuejs

export default {
	name: 'Spinner',
	components: {
		LottieAnimation
	}
};
</script>

<style>
.loader-container {
	margin: 100px 0;
	height: 100%;
	width: 100%;
	display: flex;
	justify-content: center;
}

/* .loader {
  border: 5px solid #f3f3f3;
  -webkit-animation: spin 1s linear infinite;
  animation: spin 1s linear infinite;
  border-top: 5px solid #555;
  border-radius: 50%;
  width: 50px;
  height: 50px;
}

@-webkit-keyframes spin {
  0% {
    -webkit-transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
  }
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
} */
</style>
