package tw.eeit138.groupone.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tw.eeit138.groupone.model.DemoBean;

@Repository
public interface DemoBeanRepository extends JpaRepository<DemoBean, Integer> {

}
