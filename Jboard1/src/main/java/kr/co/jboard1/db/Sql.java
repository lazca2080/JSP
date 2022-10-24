package kr.co.jboard1.db;

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
												+ "`title`=?,"
												+ "`content`=?,"
												+ "`uid`=?,"
												+ "`regip`=?,"
												+ "`rdate`=NOW()";
	
	public static final String SELECT_ARTICLE = "SELECT * FROM `board_article`";
	public static final String SELECT_VIEW = "SELECT * FROM `board_article` WHERE `no`=?";
}
