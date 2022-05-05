package tw.eeit138.groupone.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tw.eeit138.groupone.dao.DepartmentRepository;
import tw.eeit138.groupone.dao.EmployeeRepository;
import tw.eeit138.groupone.dao.StateRepository;
import tw.eeit138.groupone.dao.TitleBeanRepository;
import tw.eeit138.groupone.model.DepartmentBean;
import tw.eeit138.groupone.model.EmployeeBean;
import tw.eeit138.groupone.model.StateBean;
import tw.eeit138.groupone.model.TitleBean;

@Service
public class BackendSystemService {

	@Autowired
	private EmployeeRepository empDao;

	@Autowired
	private DepartmentRepository depDao;

	@Autowired
	private TitleBeanRepository titDao;

	@Autowired
	private StateRepository statDao;

	// 登入驗證
	public EmployeeBean login(Integer empId, String pass) {
		List<EmployeeBean> employeeBean = empDao.login(empId, pass);
		try {
			if (employeeBean.get(0) != null) {
				return employeeBean.get(0);
			}
		} catch (Exception e) {
			System.out.println("no data!");
		}

		return new EmployeeBean();
	};

	//
	public EmployeeBean findById(Integer empId) {
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 確認驗證碼，如果沒有找到就回傳空的EmployeeBean
	public EmployeeBean checkIdCode(Integer id, String idCode) {
		List<EmployeeBean> employeeBean = empDao.checkIdCode(id, idCode);
		try {
			if (employeeBean.get(0) != null) {
				return employeeBean.get(0);
			}
		} catch (Exception e) {
			System.out.println("no data!");
		}

		return new EmployeeBean();
	}

	// 找部門編號及職稱編號
	public List<EmployeeBean> selectSuperiorName(Integer empId, String departId, String titleId) {
		List<EmployeeBean> superiorName = empDao.selectSuperiorName(empId, departId, titleId);
		return superiorName;
	}

	// 找資料庫所有員工mail
	public EmployeeBean findEmpEmail(String empEmail) {
		List<EmployeeBean> allEmp = empDao.findAll();
		EmployeeBean empBean = new EmployeeBean();
		for (EmployeeBean employeeBean : allEmp) {
			if (employeeBean.getEmail().equals(empEmail)) {
				empBean.setEmpId(employeeBean.getEmpId());
				empBean.setEmail(empEmail);
				empBean.setUsername(employeeBean.getUsername());
				return empBean;
			}
		}
		return null;
	}

	// 找所有部門
	public List<DepartmentBean> selectAllDname() {
		List<DepartmentBean> departmentBean = depDao.findAll();
		return departmentBean;
	}

	// 找所有職稱
	public List<TitleBean> selectAllTitName() {
		List<TitleBean> titleBean = titDao.findAll();
		return titleBean;
	}

	// 找所有員工狀態
	public List<StateBean> selectAllStateName() {
		List<StateBean> stateBean = statDao.findAll();
		return stateBean;
	}

	// 找所有員工
	public List<EmployeeBean> selectAllEmployee() {
		List<EmployeeBean> employeeBeans = empDao.findAll();
		return employeeBeans;
	}

	// 員工修改員工基本資料
	@Transactional
	public EmployeeBean empUpdateInformation(Integer empId, String photo, String username, String birthday,
			String fkDeptno, String fkTitleId, String sex, String superiorName, String id, String phone, String highEdu,
			String highLevel, String highMajor, String emergencyContact, String contactRelationship,
			String contactPhone, String address, String email) {
		empDao.empUpdateInformation(empId, photo, username, birthday, fkDeptno, fkTitleId, sex, superiorName, id, phone,
				highEdu, highLevel, highMajor, emergencyContact, contactRelationship, contactPhone, address, email);
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 管理員修改員工基本資料
	@Transactional
	public EmployeeBean adminUpdateEmpInformation(Integer empId, String photo, String username, String birthday,
			String fkDeptno, String fkTitleId, String sex, String superiorName, String id, String phone, String highEdu,
			String highLevel, String highMajor, String emergencyContact, String contactRelationship,
			String contactPhone, String address, String email, String fkStateId) {
		empDao.adminUpdateEmpInformation(empId, photo, username, birthday, fkDeptno, fkTitleId, sex, superiorName, id,
				phone, highEdu, highLevel, highMajor, emergencyContact, contactRelationship, contactPhone, address,
				email, fkStateId);
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	// 修改密碼
	@Transactional
	public EmployeeBean updatePass(Integer empId, String password) {
		empDao.updatePass(empId, password);
		Optional<EmployeeBean> op = empDao.findById(empId);

		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	//修改員工帳號狀態
	public void updateStateId(Integer empId, String fkStateId) {
		empDao.updateStateId(empId, fkStateId);
	}

	// 新增員工
	public void addEmpInformation(EmployeeBean emp) {
		empDao.save(emp);
	}

	// 刪除員工
	public void deleteEmp(Integer empId) {
		empDao.deleteById(empId);
	}
	
	public List<EmployeeBean> findAll() {
		return empDao.findAll();
	}
}
