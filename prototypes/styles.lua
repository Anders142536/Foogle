local styles = data.raw["gui-style"].default

styles.foo_draghandle = {
    type = "empty_widget_style",
    parent = "draggable_space_header",
    left_margin = 4,
    right_margin = 4,
    height = 24,
    horizontally_stretchable = "on"
}
styles.foo_subheader = {
    type = "frame_style",
    parent = "subheader_frame",
    horizontally_stretchable = "on"
}