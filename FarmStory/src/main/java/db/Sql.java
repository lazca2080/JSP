package db;


public class Sql {
		
	// user
	public static final String INSERT_USER = "INSERT INTO `board_user` set "
											+ "`uid`=?,"
											+ "`pass`=SHA2(?, 256),"
											+ "`name`=?,"
											+ "`nick`=?,"
											+ "`email`=?,"
											+ "`hp`=?,"
											+ "`zip`=?,"
											+ "`addr1`=?,"
											+ "`addr2`=?,"
											+ "`regip`=?,"
											+ "`rdate`=NOW()";
	
	public static final String SELECT_TERMS = "SELECT * FROM `board_terms`";
	public static final String SELECT_USER = "SELECT * FROM `board_user` WHERE `uid`=? and `pass`=SHA2(?, 256)";
	public static final String SELECT_COUNT_UID = "SELECT COUNT(`uid`) FROM `board_user` WHERE `uid`=?";
	public static final String SELECT_COUNT_NICK = "SELECT COUNT(`nick`) FROM `board_user` WHERE `nick`=?";
	
	// board
	public static final String INSERT_ARTICLE = "insert into `board_article` set "
												+ "`cate`=?,"
												+ "`title`=?,"
												+ "`content`=?,"
												+ "`file`=?,"
												+ "`uid`=?,"
												+ "`regip`=?,"
												+ "`rdate`=NOW()";
	
	public static final String INSERT_FILE = "INSERT INTO `board_file` set "
											+ "`parent`=?,"
											+ "`newName`=?,"
											+ "`oriName`=?";
	
	public static final String INSERT_COMMENT = "INSERT INTO `board_article` set "
											+ "`parent`=?,"
											+ "`cate`=?,"
											+ "`content`=?,"
											+ "`uid`=?,"
											+ "`regip`=?,"
											+ "`rdate`=NOW()";
	
	public static final String SELECT_COUNT_TOTAL = "SELECT count(`no`) FROM `board_article` WHERE `parent` = 0 AND `cate`=?";
	
	public static final String SELECT_MAX_NO = "SELECT MAX(`no`) FROM `board_article`";
	
	public static final String SELECT_ARTICLES = "SELECT a.*, `nick` FROM `board_article` "
												+ "AS a JOIN `board_user` "
												+ "AS b ON a.uid = b.uid "
												+ "WHERE `parent` = 0 AND `cate`=? "
												+ "ORDER BY a.`no` desc "
												+ "LIMIT ?, 10";
	
	public static final String SELECT_ARTICLE = "SELECT a.*, b.fno, b.parent AS pno, b.newName, b.oriName, b.download "
												+ "FROM `board_article` AS a "
												+ "LEFT JOIN `board_file` AS b "
												+ "ON a.`no` = b.`parent` "
												+ "WHERE `no` = ?";
	
	public static final String SELECT_FILE = "SELECT * FROM `board_file` WHERE `parent`=?";
	
	public static final String SELECT_COMMENTS = "SELECT a.*, b.`nick` FROM `board_article` AS a "
												+ "JOIN `board_user` AS b "
												+ "ON a.uid = b.uid "
												+ "WHERE `parent`=? AND `cate`=? ORDER BY `no` ASC";
	
	public static final String SELECT_COMMENT_LATEST = "SELECT a.*, b.nick FROM `board_article` AS a "
														+ "JOIN `board_user` AS b USING (`uid`) "
														+ "WHERE `parent` != 0 AND `cate`=? ORDER BY `no` DESC LIMIT 1 ";
	
	
	public static final String SELECT_LATESTS = "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`=? AND `title` IS NOT NULL ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`=? AND `title` IS NOT NULL ORDER BY `no` DESC LIMIT 5) "
												+ "UNION "
												+ "(SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`=? AND `title` IS NOT NULL ORDER BY `no` DESC LIMIT 5)";
	
	public static final String SELECT_LATEST = "SELECT `no`, `title`, `rdate` FROM `board_article` WHERE `cate`=? ORDER BY `no` DESC LIMIT 3";
	
	public static final String UPDATE_ARTICLE = "UPDATE `board_article` SET `title`=?, `content`=?, `rdate`=NOW() WHERE `no`=?";
	
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit`=`hit`+1 WHERE `no`=?";
	
	public static final String UPDATE_FILE_DOWNLOAD = "UPDATE `board_file` SET `download` = `download`+1 WHERE `fno`=?";
	
	public static final String UPDATE_COMMENT = "UPDATE `board_article` SET "
												+ "`content`=?, "
												+ "`rdate`=now() "
												+ "WHERE `no`=?";
	
	public static final String UPDATE_ARTICLE_COMMENT_PLUS = "UPDATE `board_article` SET `comment`=`comment`+1 WHERE `no`=?";
	
	public static final String UPDATE_ARTICLE_COMMENT_MINUS = "UPDATE `board_article` SET `comment`=`comment`-1 WHERE `no`=?";
	
	public static final String DELETE_ARTICLE = "DELETE FROM `board_article` WHERE `no`=? or `parent`=?";
	
	public static final String DELETE_FILE = "DELETE FROM `board_file` WHERE `parent`=?";
	
	public static final String DELETE_COMMENT = "DELETE FROM `board_article` WHERE `no`=?";
}
