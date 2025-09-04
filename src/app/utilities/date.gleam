import gleam/int
import gleam/time/calendar
import gleam/time/timestamp

const suffix = "T00:00:00Z"

pub fn compare_post_dates(date1: String, date2: String) {
  let assert Ok(date_1) = timestamp.parse_rfc3339(date1 <> suffix)
  let assert Ok(date_2) = timestamp.parse_rfc3339(date2 <> suffix)
  timestamp.compare(date_1, date_2)
}

pub fn pretty_print(date: String) -> String {
  let assert Ok(parsed_date) = timestamp.parse_rfc3339(date <> suffix)
  let date_calendar = timestamp.to_calendar(parsed_date, calendar.utc_offset)

  calendar.month_to_string({ date_calendar.0 }.month)
  <> " "
  <> int.to_string({ date_calendar.0 }.day)
  <> ", "
  <> int.to_string({ date_calendar.0 }.year)
}
