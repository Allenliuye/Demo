package tw.eeit138.groupone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.DemoBeanRepository;
import tw.eeit138.groupone.model.DemoBean;


@Service
public class DemoService {

	
	@Autowired
	private DemoBeanRepository Dao;
	
	// 所有資料
	public List<DemoBean> selectAll() {
		List<DemoBean> DemoBeans = Dao.findAll();
		return DemoBeans;
	}
    //新增
	public DemoBean insert(DemoBean db) {
		return Dao.save(db);
	}
	
	public void deletePage(Integer idx) {
		Dao.deleteById(idx);
	}
	
}
