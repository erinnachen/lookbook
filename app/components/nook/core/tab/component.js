export default function nookTab() {
  return {
    root: {
      ["x-bind:class"]() {
        return { "tab-active": this.isSelected(this.$el.id) };
      },
      ["x-bind:id"]() {
        return this.$id(
          "tab",
          this.whichChild(this.$el.parentElement, this.$refs.tablist)
        );
      },
      ["@click"]() {
        this.select(this.$el.id);
      },
      ["@mousedown.prevent"]: true,
      ["@focus"]() {
        this.select(this.$el.id);
      },
      [":tabindex"]() {
        return this.isSelected(this.$el.id) ? 0 : -1;
      },
      [":aria-selected"]() {
        return this.isSelected(this.$el.id);
      },
    },
  };
}
