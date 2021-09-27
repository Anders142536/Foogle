local styles = data.raw["gui-style"].default

styles.foo_draghandle = {
    type = "empty_widget_style",
    parent = "draggable_space_header",
    left_margin = 4,
    right_margin = 4,
    height = 24,
    horizontally_stretchable = "on"
}