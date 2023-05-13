class BlogPostPreview:
    def __init__(self, title: str, subtitle: str, date: str, slug: str):
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.slug = slug

    def as_dict(self):
        return {
            "title": self.title,
            "subtitle": self.subtitle,
            "date": self.date,
            "slug": self.slug
        }