public class ProjectCWorkerV1 {
    public void run(){
        new ProjectAWorkerV1().run();
        new ProjectBWorkerV1().run();
        System.out.println("project c worker v1");
    }
}
