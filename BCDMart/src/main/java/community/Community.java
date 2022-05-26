package community;

public class Community {
private int article_id;
private int likes;
private int view_cnt;
private String title;
private String content;
public int getArticle_id() {
	return article_id;
}
public void setArticle_id(int article_id) {
	this.article_id = article_id;
}
private String email;

public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}

public int getLikes() {
	return likes;
}
public void setLikes(int likes) {
	this.likes = likes;
}
public int getView_cnt() {
	return view_cnt;
}
public void setView_cnt(int view_cnt) {
	this.view_cnt = view_cnt;
}


}
