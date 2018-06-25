# Valid $minute parameter to Cron::Job.
type Cron::Minute = Variant[
  Integer[0,59],
  Pattern[/\A(([0-9]|[1-5][0-9])|(\*|(([0-9]|[1-5][0-9])-([0-9]|[1-5][0-9])))(\/([1-9]|[1-5][0-9]))?)\z/]
]
