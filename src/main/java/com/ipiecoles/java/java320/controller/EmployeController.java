package com.ipiecoles.java.java320.controller;

import com.ipiecoles.java.java320.model.Commercial;
import com.ipiecoles.java.java320.model.Employe;
import com.ipiecoles.java.java320.model.Manager;
import com.ipiecoles.java.java320.model.Technicien;
import com.ipiecoles.java.java320.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Map;

@RequestMapping("/employes")
@Controller
public class EmployeController extends NavBarController{

    @Autowired
    private ManagerService managerService;

    @GetMapping("/{id}")
    public String detail(@PathVariable(name = "id") Long id, Map<String, Object> model) {
        super.index(model);
        Employe employe = this.employeService.findById(id);
        if(employe instanceof Manager){
            employe = managerService.findOneWithEquipeById(id);
        }
        model.put("model", employe);

        return "employes/detail";
    }

    @GetMapping("/{id}/delete")
    public RedirectView deleteEmploye(@PathVariable(name = "id") Long id, Map<String, Object> model, RedirectAttributes attributes) {
        super.index(model);
        this.employeService.deleteEmploye(id);
        attributes.addAttribute("page", 0);
        attributes.addAttribute("size", 10);
        attributes.addAttribute("sortingProperty", "matricule");
        attributes.addAttribute("sortDirection", "ASC");
        return new RedirectView("/employes");
    }

    @GetMapping("/new/manager")
    public String createManager(Map<String, Object> model) {
        return createEmploye(model, new Manager());
    }

    @GetMapping("/new/commercial")
    public String createCommercial(Map<String, Object> model) {
        return createEmploye(model, new Commercial());
    }

    @GetMapping("/new/technicien")
    public String createTechnicien(Map<String, Object> model) {
        return createEmploye(model, new Technicien());
    }

    private String createEmploye(Map<String, Object> model, Employe employe){
        super.index(model);
        model.put("model", employe);
        return "employes/detail";
    }

    @PostMapping("/{id}")
    public <T extends Employe> RedirectView save(@PathVariable(name = "id") Long id, T employe, Map<String, Object> model) {
        super.index(model);
        if(employe != null){
            employe = this.employeService.updateEmploye(id, employe);
        }
        model.put("model", employe);

        return new RedirectView("/employes/" + id);
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String findAll(@RequestParam("page") Integer page, @RequestParam("size") Integer size, @RequestParam("sortDirection") String sortDirection, @RequestParam("sortProperty") String sortProperty, Map<String, Object> model){
        super.index(model);
        Page<Employe> pageEmploye = employeService.findAllEmployes(page, size, sortProperty, sortDirection);
        model.put("model",pageEmploye);
        model.put("size", size);
        model.put("sortDirection", sortDirection);
        model.put("sortProperty", sortProperty);
        model.put("page", page);
        model.put("pageAffichage", page + 1);
        model.put("nextPage", page + 1);
        model.put("previousPage", page - 1);
        model.put("start", (page) * size + 1);
        int end = (page + 1) * size;
        model.put("end", end > pageEmploye.getTotalElements() ? pageEmploye.getTotalElements() : end);
        return "employes/liste";
    }

}
