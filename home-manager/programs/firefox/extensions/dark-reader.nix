{...}: {
  enableOptionName = "darkReader";

  name = "addon@darkreader.org";
  storeId = "darkreader";

  settingsPolicy = {
    detectDarkTheme = true;
    fetchNews = false;
  };
}
