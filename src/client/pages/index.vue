<template>
  <div class="page">
    <h1>Home</h1>
    <div class="center" style="margin-top: 50px">
      <div class="status-cards-group">
        <div
          class="card"
          style="background: linear-gradient(to top, #fbc2eb 0%, #a6c1ee 100%)"
        >
          <div class="icon">
            <i class="bx bx-rocket"></i>
          </div>
          <div class="status">
            <h1>1</h1>
          </div>
          <div class="status-description">Appraisals in goal setting stage</div>
        </div>

        <div
          class="card"
          style="background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%)"
        >
          <div class="icon">
            <i class="bx bx-calendar-alt"></i>
          </div>
          <div class="status">
            <h1>0</h1>
          </div>
          <div class="status-description">Appraisals in mid year review</div>
        </div>

        <div
          class="card"
          style="background: linear-gradient(120deg, #d4fc79 0%, #96e6a1 100%)"
        >
          <div class="icon">
            <i class="bx bx-calendar-event"></i>
          </div>
          <div class="status">
            <h1>0</h1>
          </div>
          <div class="status-description">Appraisals in end year review</div>
        </div>

        <div
          class="card"
          style="background: linear-gradient(0deg, #fa709a 0%, #fee140 100%)"
        >
          <div class="icon">
            <i class="bx bx-user-pin"></i>
          </div>
          <div class="status">
            <h1>2</h1>
          </div>
          <div class="status-description">Peer Appraisals</div>
        </div>
      </div>

      <div class="status-user-profile">
        <div class="avatar">
          <vs-avatar size="100">
            <img
              src="https://randomuser.me/api/portraits/women/83.jpg"
              alt=""
            />
          </vs-avatar>
        </div>

        <div class="details">
          <vs-table class="table" striped>
            <!-- <template #thead>
              <vs-tr>
                <vs-th> Name </vs-th>
                <vs-th> Email </vs-th>
                <vs-th> Id </vs-th>
              </vs-tr>
            </template> -->
            <template #tbody>
              <vs-tr>
                <vs-td> Name </vs-td>
                <vs-td>
                  {{ $store.state.user.user.username }}
                </vs-td>
              </vs-tr>
              <vs-tr>
                <vs-td> Email </vs-td>
                <vs-td>
                  {{ $store.state.user.user.username }}
                </vs-td>
              </vs-tr>
              <vs-tr>
                <vs-td> Department </vs-td>
                <vs-td> IT </vs-td>
              </vs-tr>
              <vs-tr>
                <vs-td> Role </vs-td>
                <vs-td> Admin </vs-td>
              </vs-tr>
            </template>
          </vs-table>
        </div>

        <div class="action-buttons">
          <vs-button @click="logout"> Logout </vs-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  methods: {
    logout() {
      fetch("/api/logout", {
        method: "POST",
      }).then(() => location.reload());
    },
  },
};
</script>

<style>
.status-cards-group {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
}

.card {
  color: #eee;
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  width: 100%;
  margin: 20px;
  padding: 20px;
  max-width: 250px;
  height: 180px;
  border-radius: 16px;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.card .icon {
  text-align: center;
}

.card .icon i {
  font-size: 48px;
}

.card .status-description {
  font-size: 14px;
  font-weight: 600;
  text-align: center;
}

.status-user-profile {
  margin: 50px 0;
}

.status-user-profile .avatar {
  justify-content: center;
  display: flex;
}

.status-user-profile .details {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 50px;
}

.status-user-profile .details .table {
  max-width: 500px;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.action-buttons {
  display: flex;
  justify-content: center;
  margin: 20px 0;
}
</style>
