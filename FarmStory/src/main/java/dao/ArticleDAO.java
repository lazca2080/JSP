package dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ArticleDAO {
	
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private ArticleDAO() {}
	
	public void selectArticle() {}
	
	public void selectArticles() {
		
		try {
			logger.info("selectArticles");
			
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public void insertArticle() {}
	
	public void updateArticle() {}
	
	public void deleteArticle() {}
	

}
