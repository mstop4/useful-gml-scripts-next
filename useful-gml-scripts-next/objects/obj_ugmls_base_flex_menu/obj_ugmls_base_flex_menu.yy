{
  "$GMObject":"",
  "%Name":"obj_ugmls_base_flex_menu",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_ugmls_base_flex_menu",
  "overriddenProperties":[],
  "parent":{
    "name":"Base Menu",
    "path":"folders/Useful GML Script Library/Components/Flex Menu System/Base Menu.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"player_controller","filters":[],"listItems":[],"multiselect":false,"name":"player_controller","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"noone","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"enabled","filters":[],"listItems":[],"multiselect":false,"name":"enabled","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"true","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"label_font","filters":[
        "GMFont",
      ],"listItems":[],"multiselect":false,"name":"label_font","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"value_font","filters":[
        "GMFont",
      ],"listItems":[],"multiselect":false,"name":"value_font","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"menu_max_width","filters":[],"listItems":[],"multiselect":false,"name":"menu_max_width","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"\"50%\"","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"menu_max_height","filters":[],"listItems":[],"multiselect":false,"name":"menu_max_height","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"600","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"menu_padding","filters":[],"listItems":[],"multiselect":false,"name":"menu_padding","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"4","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"menu_draw_border","filters":[],"listItems":[],"multiselect":false,"name":"menu_draw_border","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"item_draw_border","filters":[],"listItems":[],"multiselect":false,"name":"item_draw_border","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"item_width","filters":[],"listItems":[],"multiselect":false,"name":"item_width","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"\"auto\"","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"item_height","filters":[],"listItems":[],"multiselect":false,"name":"item_height","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"50","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"item_padding","filters":[],"listItems":[],"multiselect":false,"name":"item_padding","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"4","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"item_margin","filters":[],"listItems":[],"multiselect":false,"name":"item_margin","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"4","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"value_node_default_width","filters":[],"listItems":[],"multiselect":false,"name":"value_node_default_width","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"50","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"item_font","filters":[
        "GMFont",
      ],"listItems":[],"multiselect":false,"name":"item_font","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"cursor_spr","filters":[
        "GMSprite",
      ],"listItems":[],"multiselect":false,"name":"cursor_spr","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"cursor_move_sfx","filters":[
        "GMSound",
      ],"listItems":[],"multiselect":false,"name":"cursor_move_sfx","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"cursor_confirm_sfx","filters":[
        "GMSound",
      ],"listItems":[],"multiselect":false,"name":"cursor_confirm_sfx","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"cursor_offset_x","filters":[],"listItems":[],"multiselect":false,"name":"cursor_offset_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"32","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"sub_cursor_spr","filters":[
        "GMSprite",
      ],"listItems":[],"multiselect":false,"name":"sub_cursor_spr","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"binding_cursor_offset_x","filters":[],"listItems":[],"multiselect":false,"name":"binding_cursor_offset_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"64","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"spinner_scroll_arrows_spr","filters":[
        "GMSprite",
      ],"listItems":[],"multiselect":false,"name":"spinner_scroll_arrows_spr","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"value_change_sfx","filters":[
        "GMSound",
      ],"listItems":[],"multiselect":false,"name":"value_change_sfx","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"use_control_icons","filters":[],"listItems":[],"multiselect":false,"name":"use_control_icons","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"True","varType":3,},
    {"$GMObjectProperty":"v1","%Name":"keyboard_icons","filters":[],"listItems":[],"multiselect":false,"name":"keyboard_icons","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"gamepad_icons","filters":[],"listItems":[],"multiselect":false,"name":"gamepad_icons","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"keyboard_icons_index","filters":[],"listItems":[],"multiselect":false,"name":"keyboard_icons_index","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"gamepad_icons_index","filters":[],"listItems":[],"multiselect":false,"name":"gamepad_icons_index","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"control_icons_scale","filters":[],"listItems":[],"multiselect":false,"name":"control_icons_scale","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"lock_icon_offset_x","filters":[],"listItems":[],"multiselect":false,"name":"lock_icon_offset_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"64","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"view_scroll_duration","filters":[],"listItems":[],"multiselect":false,"name":"view_scroll_duration","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"5","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "visible":true,
}