function DetectTimeZone() {
  console.log(Intl.DateTimeFormat().resolvedOptions().timeZone);
}