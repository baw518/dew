package org.kosta.dew.model.dao;

import java.util.List;

import org.kosta.dew.model.vo.CommentVO;
import org.kosta.dew.model.vo.DiscussVO;

public interface DiscussDAO {

	public abstract List<DiscussVO> getAllDiscussList(String pageNo);

	public abstract int registerDiscussion(DiscussVO dsvo);

	public abstract DiscussVO findDiscussContent();

	public abstract List<DiscussVO> searchDisscuss(String title);

	public abstract int deleteRequestDiscuss(DiscussVO dsvo);

	public abstract int registerDiscussComment(CommentVO cvo);

	public abstract int updateDiscussComment(CommentVO cvo);

	public abstract int deleteDiscussComment(CommentVO cvo);

	public abstract int totalContent();

}