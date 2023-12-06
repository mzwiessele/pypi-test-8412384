import logging

import click


@click.group()
def cli():
    """CLI Entrypoint."""
    ...



if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    cli()
