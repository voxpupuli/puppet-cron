# Valid $month parameter to Cron::Job.
type Cron::Month = Variant[
  Cron::Monthname,
  Integer[1,12],
  Pattern[/\A(([1-9]|1[0-2])|(\*|(([1-9]|1[0-2])-([1-9]|1[0-2])))(\/([1-9]|1[0-2]))?)\z/]
]
