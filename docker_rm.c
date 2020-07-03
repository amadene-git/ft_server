#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

char *get_file(int fd)
{
	char *str = malloc(500);
	int i;

	i = 0;
	if (!(fd = open("docker_rm.txt", O_RDWR | O_CREAT)))
		return (NULL);
	while(read(fd, str++, 1))
		i++;
	*str = 0;
	close(fd);
	return (str - i - 1);
}

int	ft_strlen(char *str)
{
	int i = 0;

	while(str[i])
		i++;
	return (i);
}

void	str_n_copy(char *dest, char *src, int n)
{
	int i;

	i = -1;
	while(++i < n)
		*dest++ = *src++;
}

char	*ft_strdup(char *str)
{
	int i = ft_strlen(str);
	char *cpy = malloc(i + 1);
	while(*str)
		*cpy++ = *str++;
	*cpy = 0;
	return (cpy - i);

}

int main()
{
	int fd;
	char *docker_rm = ft_strdup("docker rm             ");
	char *str;
	while(1)
	{
		system("docker ps -a | grep img | cut -c -12 > docker_rm.txt");
		str = get_file(fd);
		if (!*str)
			break;
		str_n_copy(docker_rm + 10, str, 12);
		system(docker_rm);
		free(str);
	}
	free(str);
	free(docker_rm);
	system("docker image rm img ; rm docker_rm.txt");//pour ma defense, je rentrais d'une soirée bien arrosée...
	return (0);
}
