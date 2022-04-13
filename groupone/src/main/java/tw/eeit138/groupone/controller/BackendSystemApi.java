package tw.eeit138.groupone.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import tw.eeit138.groupone.dao.EmployeeRepository;
import tw.eeit138.groupone.model.EmployeeBean;

@RestController
public class BackendSystemApi {

	@Autowired
	private EmployeeRepository empDao;
	
	
	public Optional<EmployeeBean> findById(@RequestParam Integer empId) {
		return empDao.findById(empId);
	}
}
