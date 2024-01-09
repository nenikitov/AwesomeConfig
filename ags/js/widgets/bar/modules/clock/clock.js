import GLib from "gi://GLib";

import Widget from "resource:///com/github/Aylur/ags/widget.js";

import { seconds } from "../../../../utils/time.js";

/** @type {ClockConfig} */
const defaultArgs = {
  format: "%X",
  formatTooltip: "%c",
  interval: seconds(1),
  vertical: false,
};

/**
 * @param {ClockArgs} args
 */
export function Clock(args) {
  const config = Object.assign({}, defaultArgs, args);

  return Widget.Label({
    class_name: "clock" + (args.class ? ` ${args.class}` : ""),
    justification: "center",
    angle: config.vertical ? 90 : 0,
    connections: [
      [
        config.interval,
        (label) => {
          const date = GLib.DateTime.new_now_local();
          label.label = date.format(config.format) || "";
          label.tooltip_text = date.format(config.formatTooltip);
        },
      ],
    ],
  });
}
