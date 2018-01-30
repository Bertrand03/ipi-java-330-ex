package com.ipiecoles.java.java320.controller;

import com.ipiecoles.java.java320.model.Manager;
import com.ipiecoles.java.java320.model.Technicien;
import com.ipiecoles.java.java320.service.TechnicienService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Map;

@RequestMapping("/techniciens")
@Controller
public class TechnicienController extends NavBarController{
    @Autowired
    private TechnicienService technicienService;

    @PostMapping("/{id}")
    public RedirectView save(@PathVariable(name = "id") Long id, Technicien employe, Map<String, Object> model) {
        if(employe != null){
            employe = this.employeService.updateEmploye(id, employe);
        }
        model.put("model", employe);

        return new RedirectView("/employes/" + id);
    }

    @PostMapping("/save")
    public RedirectView saveNew(Technicien employe, Map<String, Object> model) {
        employe = this.employeService.creerEmploye(employe);
        model.put("model", employe);

        return new RedirectView("/employes/" + employe.getId());
    }

    @GetMapping("/{id}/manager/{idManager}/delete")
    public RedirectView removeManager(@PathVariable(name = "id") Long id, @PathVariable(name = "idManager") Long idManager){
        Technicien technicien = (Technicien) employeService.findById(id);
        if(technicien.getManager() != null && technicien.getManager().getId().equals(idManager)){
            technicien.setManager(null);
            this.employeService.updateEmploye(id, technicien);
        }
        else {
            //Erreur
        }

        return new RedirectView("/employes/" + id);
    }

    @GetMapping("/{id}/manager/add")
    public RedirectView addManager(@PathVariable(name = "id") Long id, @RequestParam(name = "matricule") String matricule){
        Technicien technicien = (Technicien) employeService.findById(id);
        Manager manager = (Manager) employeService.findMyMatricule(matricule);
        technicien.setManager(manager);
        this.employeService.updateEmploye(id, technicien);

        return new RedirectView("/employes/" + id);
    }
}
