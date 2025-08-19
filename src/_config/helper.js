import { DateTime } from "luxon";

export function readableDate(dateObj, format, zone) {
  return DateTime.fromJSDate(dateObj, { zone: zone || "utc" }).toFormat(format || "dd LLLL yyyy");
}