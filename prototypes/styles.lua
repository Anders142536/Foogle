local styles = data.raw["gui-style"].default
local button_style = styles["button"]

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
styles.foo_frame_under_subheader = {
    type = "frame_style",
    padding = 12,
    graphical_set = {},
    vertical_align = "center"
}
styles.foo_search_button = {
    type = "button_style",
    parent = "tool_button",
    left_margin = 8
}
styles.foo_toolbar_button = {
    type = "button_style",
    parent = "tool_button"
}
styles.foo_clicked_toolbar_button = {
    type = "button_style",
    parent = "tool_button",
    default_graphical_set = button_style.clicked_graphical_set,
    clicked_graphical_set = button_style.default_graphical_set
}
styles.foo_filter_flow = {
    type = "horizontal_flow_style",
    horizontally_stretchable = "on"
}