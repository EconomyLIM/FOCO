package com.fastcampus.ch4;

import com.fastcampus.ch4.domain.CommentDto;
import com.fastcampus.ch4.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@ResponseBody
public class CommentController {
    @Autowired
    CommentService service;
    @GetMapping ("/comments")
     public ResponseEntity<List<CommentDto>> list(Integer bno){

        List<CommentDto> list = null;
        try {
             list = service.getList(bno);
             return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK); //200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); //400
        }
    }

    //댓글을 삭제하는 메소드

    @DeleteMapping("/comments/{cno}")
    @ResponseBody
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session){
        String commenter = (String) session.getAttribute("email");

        try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt != 1){
                throw new Exception("Delete Failed");
            }
            return new ResponseEntity<>("Delete Ok", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Delete Error",HttpStatus.BAD_REQUEST);
        }
    }

    //댓글을 등록하는 메소드
    @PostMapping("/comments")
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session){
        String commenter = (String) session.getAttribute("email");
        dto.setCommenter(commenter);
        dto.setBno(bno);
        System.out.println("dto = " +dto);

        try {
            if(service.write(dto) != 1){
                throw new Exception("write Failed");
            }
            return new ResponseEntity<>("Write_Success",HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("Write_Error",HttpStatus.BAD_REQUEST);
        }
    }

    //댓글을 수정하는 메소드
    @PatchMapping("/comments/{cno}")
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session){
        String commenter = (String) session.getAttribute("email");
        dto.setCommenter(commenter);
//        dto.setCno(cno);
//        System.out.println("dto = " +dto);
        dto.setCno(cno);

        try {
            if(service.modify(dto) != 1){
                throw new Exception("Modify Failed");
            }
            return new ResponseEntity<>("Modify_Success",HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("Modify_Error",HttpStatus.BAD_REQUEST);
        }
    }

}
