export default {
  data() {
    return {
      ratings: [
        {
          value: 1,
          name: "1. Major Improvement Needed",
        },
        {
          value: 2,
          name: "2. Needs Improvement",
        },
        {
          value: 3,
          name: "3. Meet Expectations",
        },
        {
          value: 4,
          name: "4. Exceed Expectations",
        },
        {
          value: 5,
          name: "5. Far Exceed Expectations",
        },
      ],
      rules: {
        required: (value) => !!value || "Required.",
        email: (v) => /.+@.+/.test(v) || "E-mail must be valid",
      },
    };
  },

  methods: {
    getStatus(status, stage) {
      if (status === 0 && stage === 0) {
        return "Goals Setting Stage Pending Employee Goals Submission";
      } else if (stage === 0 && status === 1) {
        return "'Goals Setting Stage Pending Manager/Supervisor Goal Approved'";
      } else if (stage === 0 && status === 2) {
        return "Goals Setting Stage Goals Approved By Manager/Supervisor";
      } else if (stage === 1 && status === 3) {
        return "Mid Year Pending Employee input";
      } else if (stage === 1 && status === 4) {
        return "Mid Year Pending Employee submit";
      } else if (stage === 1 && status === 5) {
        return "Mid Year Pending Manager/Supervisor input";
      } else if (stage === 1 && status === 6) {
        return "Mid Year Approved By Manager/Supervisor";
      } else if (stage === 2 && status === 7) {
        return "End Year Pending Employee input";
      } else if (stage === 2 && status === 8) {
        return "End Year Pending Employee submit";
      } else if (stage === 2 && status === 9) {
        return "End Year Pending Manager/Supervisor input";
      } else if (stage === 2 && status === 10) {
        return "End Year  Approved By Manager/Supervisor";
      } else {
        return "Unknown Stage";
      }
    },
    ratingName(rating) {
      switch (rating) {
        case 1:
          return "1. Major Improvement Needed";
        case 2:
          return "2. Needs Improvement";
        case 3:
          return "3. Meet Expectations";
        case 4:
          return "4. Exceed Expectations";
        case 5:
          return "5. Far Exceed Expectations";
        default:
          return "";
      }
    },
  },
};
