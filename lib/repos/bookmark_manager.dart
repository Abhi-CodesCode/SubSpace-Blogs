class BookmarkManager {
static List<String> _bookmarkedIds = [];

static void addBookmark(String id) {
_bookmarkedIds.add(id);
}

static void removeBookmark(String id) {
_bookmarkedIds.remove(id);
}

static bool isBookmarked(String id) {
return _bookmarkedIds.contains(id);
}

static List<String> getBookmarkedIds() {
return _bookmarkedIds;
}
}