export default function nookIcon() {
  return {
    spin: false,
    style: "line",
    get fill() {
      return this.style === "fill";
    },
    set fill(val) {
      this.style = val === true ? "fill" : "line";
    },
    init() {
      this.style = this.$el.getAttribute("data-style");
      this.spin = this.$el.getAttribute("data-spin") === "true";
    },
    root: {
      ["x-bind:data-style"]: "style",
      ["x-bind:data-spin"]: "spin",
    },
  };
}
