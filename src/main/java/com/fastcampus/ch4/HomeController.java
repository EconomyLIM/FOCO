package com.fastcampus.ch4;

import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller

public class HomeController {
    @Autowired
    BoardService boardService;
    @GetMapping("/")
    public String list(Integer page, Integer pageSize, Model m,HttpServletRequest request) {
        if(page == null) page = 1;
        if(pageSize == null) pageSize = 10;

        try {

            int totalCnt = boardService.getCount();
            PageHandler pageHandler = new PageHandler(totalCnt, page, pageSize);

            Map map = new HashMap();
            map.put("offset",(page-1)*pageSize);
            map.put("pageSize", pageSize);
            List<BoardDto> list = boardService.getPage(map);
            m.addAttribute("list", list);
            m.addAttribute("ph",pageHandler);
            m.addAttribute("page",page);
            m.addAttribute("pageSize",pageSize);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index";
    }
}
