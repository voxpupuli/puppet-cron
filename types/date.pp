# Valid $date (day of month) parameter to Cron::Job.
type Cron::Date = Variant[
  Integer[1,31],
  Pattern[/\A(([1-9]|[1-2][0-9]|3[0-1])|(\*|(([1-9]|[1-2][0-9]|3[0-1])-([1-9]|[1-2][0-9]|3[0-1])))(\/([1-9]|[1-2][0-9]|3[0-1]))?)\z/]
]
