<template>
  <div class="page">
    <h1>My Appraiasals</h1>
    <div class="center grid" style="margin-top: 50px">
      <div class="appraisal-grid">
        <div class="appraisal-lists">
          <div class="appraisal-list-item primary">2021 Appraisal</div>
          <div class="appraisal-list-item">2022 Appraisal</div>
          <div class="appraisal-list-item">2023 Appraisal</div>
        </div>
        <div class="appraisal-item-open">
          <div class="appraisal-item"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
};
</script>

<style>
.appraisal-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.appraisal-lists {
  width: 300px;
}

.appraisal-lists > .appraisal-list-item {
  padding: 10px;
  background: #eee;
  border-radius: 16px;
  margin-right: 20px;
  margin-bottom: 10px;
  font-weight: 600;
  opacity: 0.7;
  text-align: center;
}

.appraisal-item {
  width: 100%;
  min-height: 600px;
  background: #f2f2f2;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
  border-radius: 16px;
}

.appraisal-item-open {
  max-width: 800px;
  width: 100%;
}

@media only screen and (max-width: 800px) {
  .appraisal-lists > .appraisal-list-item {
    margin-right: unset;
  }
}
</style>
