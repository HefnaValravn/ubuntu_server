
For this exercise, I first need to set up Docker on windows to be able to run containers.

After installing docker, I can create a .yaml compose file in which I specify:

- Under services and then web, I specify which image from dockerhub I want to use (in my case, a nginx webserver
running on alpine linux)
- the name of the container
- the volumes being used (copying over the files from my own device to the server's directory)
- the ports being used. I chose to use port 8080 on my machine because it's not a system port and it generally doesn't
get used much.

Once that's done, I can create the directory I specified in the volumes part of the .yaml file and put the index.html
file that I'll need for the assignment in there. Once this is done, I can run the command `docker-compose up -d` from
a terminal in the same directory as the .yaml file to compose the container (-d is for detach, or make it run in the
background).

Once the container is up and running, I can verify its status from docker desktop, and go to `http://localhost:8080`
on my browser to see the ordered list of the two youtube links I was supposed to add to the index file.

Once that part of the assignment is done, I can make an account on dockerhub with the right username
(PLEASE NOTE, SINCE I HAVE TWO SURNAMES AND THEY ARE BOTH RELATIVELY LONG I COULDN'T FIT MY ENTIRE NAME IN THE
USERNAME. FOR THIS REASON, MY USERNAME ON DOCKERHUB IS "nicolasbenedettisasm2425" INSTEAD OF
"nicolasbenedettigonzalezsasm2425". The public repository that the assignment image is found in is still called
correctly, with both of my surnames and not just one.)

Then, I can tag my image with the command `docker tag nginx:alpine nicolasbenedettisasm2425/sasm_docker:latest`, where
"latest" is the tag I choose to give this image on my repository. Then I can push the image to the repository on
dockerhub with `docker push nicolasbenedettisasm2425/sasm_docker`, evidently after creating said public repository
on dockerhub.

Finally, I can fix the provided .yaml compose file by fixing a few syntax errors, like trailing "s"'s at the end of
some directives, or missing commas for the ports directives, or not mentioning both volumes being used at the end
of the file. The original .yaml file and the fixed file can both be found on "/etc/docker-exercise", together with
the .yaml file I used to create my container with the ordered list and the index.html file (under "src/") that
contains said list.
After fixing the file, I can use the `docker-compose up` command (optionally specifying the .yaml file with -f) to
start the container. Once I do this, I will get the message that both the nextcloud image and the postgres image are
running, and I can finally access the nextcloud frontend by navigating to localhost:8080, as defined in the .yaml
file.
